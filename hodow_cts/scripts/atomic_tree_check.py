# Python mirror of createImageAtomicOperationTests; usage: atomic_tree_check.py <mustpass image/atomic-operations.txt>
import sys
ops = ['add','sub','inc','dec','min','max','and','or','xor','exchange','compare_exchange']
imgs = ['1d','1d_array','2d','2d_array','3d','cube','cube_array','buffer']
fmts = [('r32ui','u'),('r32i','i'),('r32f','f'),('r64ui','u'),('r64i','i'),('rg16f','h'),('rgba16f','h')]
out = []
for op in ops:
    for img in imgs:
        for transfer in (0, 1):
            for rt in ('normal_read', 'sparse_read'):
                for bt in ('normal_img', 'sparse_img'):
                    for (fname, ftype) in fmts:
                        for tiling in ('', '_linear'):
                            if img == 'buffer' and ftype not in 'fh' and tiling == '_linear': continue
                            if bt == 'sparse_img' and (img not in ('2d','2d_array','cube','cube_array','3d') and False): pass
                            if bt == 'sparse_img' and (img not in ('2d','2d_array','cube','cube_array','3d') or tiling == '_linear'):
                                pass
                            # vkImageType 2D or 3D: 2d, 2d_array, cube, cube_array, 3d
                            if bt == 'sparse_img' and (img not in ('2d','2d_array','cube','cube_array','3d') or tiling == '_linear'): continue
                            if ftype in 'fh' and op not in ('add','min','max','exchange'): continue
                            if rt == 'sparse_read':
                                if transfer: continue
                                if img in ('1d','1d_array','buffer'): continue
                            for kind in ('end_result', 'intermediate_values'):
                                out.append('.'.join([op, img, ('' if not transfer else '') + ('transfer' if transfer else 'notransfer'), rt, bt, fname + '_' + kind + tiling]))
out.append('indexing.storage_texel_buffer_atomic_32bit_index')
ms = [l.strip().replace('dEQP-VK.image.atomic_operations.', '') for l in open(sys.argv[1])]
print(len(out), len(set(out)), len(ms), len(set(out) - set(ms)), len(set(ms) - set(out)))
print(list(set(out) - set(ms))[:5], list(set(ms) - set(out))[:5])
